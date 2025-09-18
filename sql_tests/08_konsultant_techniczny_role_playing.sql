-- Konsultant techniczny z AI_COMPLETE
-- Technika: Role-playing - ekspert techniczny z praktycznymi rekomendacjami

SELECT AI_COMPLETE(
    model => 'claude-4-sonnet',
    prompt => 'Jesteś Principal Data Architect z doświadczeniem w Snowflake, AWS i architekturze danych. Dostarczasz praktyczne rekomendacje techniczne.

Jak zoptymalizować pipeline ETL przetwarzający 500GB danych dziennie w Snowflake?',
    model_parameters => {
        'temperature': 0.6,
        'max_tokens': 2000
    },
    response_format => {
        'type': 'json',
        'schema': {
            'type': 'object',
            'properties': {
                'analiza_obecnego_stanu': {
                    'type': 'string',
                    'description': 'Ocena obecnej sytuacji'
                },
                'rekomendacje': {
                    'type': 'array',
                    'items': {
                        'type': 'object',
                        'properties': {
                            'kategoria': {
                                'type': 'string',
                                'enum': ['architektura', 'wydajnosc', 'koszty', 'bezpieczenstwo', 'monitoring']
                            },
                            'priorytet': {
                                'type': 'string',
                                'enum': ['wysoki', 'sredni', 'niski']
                            },
                            'tytul': {'type': 'string'},
                            'opis': {'type': 'string'},
                            'implementacja': {'type': 'string'},
                            'spodziewane_korzysci': {'type': 'string'}
                        }
                    }
                },
                'architektura_docelowa': {
                    'type': 'object',
                    'properties': {
                        'opis': {'type': 'string'},
                        'komponenty': {
                            'type': 'array',
                            'items': {'type': 'string'}
                        }
                    }
                },
                'szacunki': {
                    'type': 'object',
                    'properties': {
                        'czas_implementacji_tygodnie': {'type': 'integer'},
                        'redukcja_kosztow_procent': {'type': 'integer'},
                        'poprawa_wydajnosci_procent': {'type': 'integer'}
                    }
                }
            },
            'required': ['analiza_obecnego_stanu', 'rekomendacje', 'architektura_docelowa', 'szacunki'],
            'additionalProperties': false
        }
    }
) AS konsultacja_techniczna;
