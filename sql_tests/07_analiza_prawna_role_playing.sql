-- Analiza prawna kontraktu z AI_COMPLETE
-- Technika: Role-playing - przypisanie konkretnej roli eksperta

SELECT AI_COMPLETE(
    model => 'claude-4-sonnet',
    prompt => 'Jesteś doświadczonym prawnikiem korporacyjnym z 20-letnim doświadczeniem w prawie handlowym. Analizujesz dokumenty prawne i dostarczasz strukturizowane oceny.

Przeanalizuj klauzulę: 
"Dostawca zobowiązuje się do dostarczenia towaru w terminie 30 dni od złożenia zamówienia. 
W przypadku opóźnienia, Zamawiający ma prawo do kary umownej w wysokości 0,1% wartości 
zamówienia za każdy dzień opóźnienia, jednak nie więcej niż 10% wartości całego zamówienia."',
    model_parameters => {
        'temperature': 0.3,
        'max_tokens': 1500
    },
    response_format => {
        'type': 'json',
        'schema': {
            'type': 'object',
            'properties': {
                'kluczowe_klauzule': {
                    'type': 'array',
                    'items': {
                        'type': 'object',
                        'properties': {
                            'nazwa': {'type': 'string'},
                            'tresc': {'type': 'string'},
                            'interpretacja': {'type': 'string'}
                        }
                    }
                },
                'potencjalne_ryzyka': {
                    'type': 'array',
                    'items': {
                        'type': 'object',
                        'properties': {
                            'ryzyko': {'type': 'string'},
                            'poziom': {
                                'type': 'string',
                                'enum': ['niski', 'sredni', 'wysoki']
                            },
                            'opis': {'type': 'string'}
                        }
                    }
                },
                'obszary_negocjacji': {
                    'type': 'array',
                    'items': {'type': 'string'}
                },
                'ocena_ogolna': {
                    'type': 'object',
                    'properties': {
                        'ocena': {
                            'type': 'string',
                            'enum': ['korzystna', 'neutralna', 'niekorzystna']
                        },
                        'uzasadnienie': {'type': 'string'},
                        'rekomendacje': {'type': 'string'}
                    }
                }
            },
            'required': ['kluczowe_klauzule', 'potencjalne_ryzyka', 'obszary_negocjacji', 'ocena_ogolna'],
            'additionalProperties': false
        }
    }
) AS analiza_prawna;
