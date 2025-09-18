-- Analiza rentowności inwestycji z AI_COMPLETE
-- Technika: Chain of Thought (CoT) - proces myślowy krok po kroku

WITH dane_inwestycji AS (
    SELECT 
        'Zakup nowej linii produkcyjnej' AS nazwa,
        500000 AS koszt_inwestycji,
        150000 AS roczne_oszczednosci,
        50000 AS dodatkowe_przychody,
        5 AS okres_lat
)
SELECT 
    nazwa,
    AI_COMPLETE(
        model => 'claude-4-sonnet',
        prompt => CONCAT(
            'Jesteś ekspertem finansowym wykonującym szczegółowe analizy inwestycji. Pokazuj tok rozumowania krok po kroku.

Przeanalizuj inwestycję: ',
            'Koszt: ', koszt_inwestycji, ' PLN, ',
            'Roczne oszczędności: ', roczne_oszczednosci, ' PLN, ',
            'Dodatkowe przychody: ', dodatkowe_przychody, ' PLN, ',
            'Okres: ', okres_lat, ' lat'
        ),
        model_parameters => {
            'temperature': 0.4,
            'max_tokens': 2000
        },
        response_format => {
            'type': 'json',
            'schema': {
                'type': 'object',
                'properties': {
                    'analiza_krok_po_kroku': {
                        'type': 'array',
                        'items': {
                            'type': 'object',
                            'properties': {
                                'krok': {'type': 'integer'},
                                'opis': {'type': 'string'},
                                'obliczenia': {'type': 'string'},
                                'wynik': {'type': 'string'}
                            },
                            'required': ['krok', 'opis', 'obliczenia', 'wynik']
                        }
                    },
                    'wskazniki_finansowe': {
                        'type': 'object',
                        'properties': {
                            'roi_procent': {'type': 'number'},
                            'okres_zwrotu_lat': {'type': 'number'},
                            'npv_8_procent': {'type': 'number'},
                            'irr_procent': {'type': 'number'}
                        },
                        'required': ['roi_procent', 'okres_zwrotu_lat', 'npv_8_procent', 'irr_procent']
                    },
                    'ryzyka': {
                        'type': 'array',
                        'items': {'type': 'string'}
                    },
                    'korzysci': {
                        'type': 'array',
                        'items': {'type': 'string'}
                    },
                    'rekomendacja': {
                        'type': 'object',
                        'properties': {
                            'decyzja': {
                                'type': 'string',
                                'enum': ['rekomenduje', 'nie_rekomenduje', 'wymaga_analizy']
                            },
                            'uzasadnienie': {'type': 'string'},
                            'poziom_pewnosci': {'type': 'integer'}
                        },
                        'required': ['decyzja', 'uzasadnienie', 'poziom_pewnosci']
                    }
                },
                'required': ['analiza_krok_po_kroku', 'wskazniki_finansowe', 'ryzyka', 'korzysci', 'rekomendacja'],
                'additionalProperties': false
            }
        }
    ) AS analiza_cot
FROM dane_inwestycji;
