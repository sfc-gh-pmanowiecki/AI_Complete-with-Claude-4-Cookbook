-- Pipeline analizy dokumentów ze strukturyzowanymi odpowiedziami z AI_COMPLETE
-- Technika: Łączenie wielu etapów z gwarantowaną strukturą JSON Schema

WITH 
-- Etap 1: Ekstrakcja kluczowych informacji
ekstrakcja AS (
    SELECT 
        dokument_id,
        AI_COMPLETE(
            model => 'claude-4-sonnet',
            prompt => CONCAT('Ekstraktuj kluczowe informacje z dokumentów biznesowych.

', dokument_tekst),
            model_parameters => {
                'temperature': 0.1,
                'max_tokens': 1000
            },
            response_format => {
                'type': 'json',
                'schema': {
                    'type': 'object',
                    'properties': {
                        'daty': {'type': 'array', 'items': {'type': 'string', 'format': 'date'}},
                        'kwoty': {'type': 'array', 'items': {'type': 'number'}},
                        'firmy': {'type': 'array', 'items': {'type': 'string'}},
                        'kluczowe_terminy': {'type': 'array', 'items': {'type': 'string'}}
                    }
                }
            }
        )::VARIANT AS extracted_data
    FROM dokumenty
),
-- Etap 2: Analiza ryzyka
analiza_ryzyka AS (
    SELECT 
        dokument_id,
        extracted_data,
        AI_COMPLETE(
            model => 'claude-4-sonnet',
            prompt => CONCAT('Analizuj ryzyko prawne i finansowe dokumentów.

Dane: ', extracted_data::STRING),
            model_parameters => {
                'temperature': 0.3,
                'max_tokens': 1500
            },
            response_format => {
                'type': 'json',
                'schema': {
                    'type': 'object',
                    'properties': {
                        'poziom_ryzyka': {'type': 'string', 'enum': ['niski', 'sredni', 'wysoki']},
                        'ryzyko_prawne': {'type': 'integer', 'minimum': 1, 'maximum': 10},
                        'ryzyko_finansowe': {'type': 'integer', 'minimum': 1, 'maximum': 10},
                        'uwagi': {'type': 'array', 'items': {'type': 'string'}}
                    }
                }
            }
        )::VARIANT AS risk_assessment
    FROM ekstrakcja
),
-- Etap 3: Generowanie rekomendacji
rekomendacje AS (
    SELECT 
        dokument_id,
        extracted_data,
        risk_assessment,
        AI_COMPLETE(
            model => 'claude-4-sonnet',
            prompt => CONCAT('Generuj praktyczne rekomendacje na podstawie analizy.

Analiza ryzyka: ', risk_assessment::STRING),
            model_parameters => {
                'temperature': 0.5,
                'max_tokens': 1000
            },
            response_format => {
                'type': 'json',
                'schema': {
                    'type': 'object',
                    'properties': {
                        'rekomendacje': {
                            'type': 'array',
                            'items': {
                                'type': 'object',
                                'properties': {
                                    'priorytet': {'type': 'string', 'enum': ['wysoki', 'sredni', 'niski']},
                                    'akcja': {'type': 'string'},
                                    'termin_dni': {'type': 'integer'}
                                }
                            }
                        },
                        'podsumowanie': {'type': 'string'}
                    }
                }
            }
        )::VARIANT AS recommendations
    FROM analiza_ryzyka
)
-- Finalne zestawienie z łatwym dostępem do pól
SELECT 
    dokument_id,
    extracted_data:firmy::ARRAY AS firmy,
    extracted_data:kwoty::ARRAY AS kwoty,
    risk_assessment:poziom_ryzyka::STRING AS poziom_ryzyka,
    risk_assessment:ryzyko_prawne::INTEGER AS ryzyko_prawne,
    recommendations:rekomendacje::ARRAY AS lista_rekomendacji,
    CURRENT_TIMESTAMP() AS processed_at
FROM rekomendacje;
