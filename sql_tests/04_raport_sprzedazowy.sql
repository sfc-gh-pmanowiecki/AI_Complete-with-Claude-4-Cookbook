-- Generowanie raportu sprzedażowego
-- Technika: Strukturyzacja odpowiedzi z AI_COMPLETE JSON Schema

SELECT AI_COMPLETE(
    model => 'claude-4-sonnet',
    prompt => 'Jesteś analitykiem biznesowym generującym strukturizowane raporty sprzedażowe.

Przygotuj raport dla danych:
- Sprzedaż Q4 2023: 2.5M PLN
- Sprzedaż Q1 2024: 3.1M PLN
- Liczba klientów wzrosła o 23%
- Średnia wartość zamówienia: 450 PLN (wzrost o 15%)
- Region północny: +40%, Region południowy: +5%',
    model_parameters => {
        'temperature': 0.5,
        'max_tokens': 1500
    },
    response_format => {
        'type': 'json',
        'schema': {
            'type': 'object',
            'properties': {
                'podsumowanie': {
                    'type': 'string',
                    'description': 'Krótkie podsumowanie wyników'
                },
                'kluczowe_metryki': {
                    'type': 'array',
                    'items': {
                        'type': 'object',
                        'properties': {
                            'nazwa': {'type': 'string'},
                            'wartosc': {'type': 'string'},
                            'zmiana_procent': {'type': 'number'}
                        },
                        'required': ['nazwa', 'wartosc', 'zmiana_procent']
                    }
                },
                'trendy': {
                    'type': 'string',
                    'description': 'Analiza trendów'
                },
                'rekomendacje': {
                    'type': 'array',
                    'items': {
                        'type': 'object',
                        'properties': {
                            'priorytet': {
                                'type': 'string',
                                'enum': ['wysoki', 'sredni', 'niski']
                            },
                            'tresc': {'type': 'string'}
                        },
                        'required': ['priorytet', 'tresc']
                    }
                }
            },
            'required': ['podsumowanie', 'kluczowe_metryki', 'trendy', 'rekomendacje'],
            'additionalProperties': false
        }
    }
) AS raport_json;
