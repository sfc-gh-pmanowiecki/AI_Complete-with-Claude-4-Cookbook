-- Generowanie danych testowych z AI_COMPLETE
-- Technika: Kontrola formatu wyjścia z walidacją wzorców

SELECT AI_COMPLETE(
    model => 'claude-4-sonnet',
    prompt => 'Jesteś generatorem realistycznych danych testowych. Tworzysz różnorodne, spójne dane używając polskich konwencji.

Wygeneruj 5 rekordów pracowników z polami: id, imie, nazwisko, pesel, stanowisko, wynagrodzenie, data_zatrudnienia, adres (ulica, miasto, kod_pocztowy)',
    model_parameters => {
        'temperature': 0.8,
        'max_tokens': 1500
    },
    response_format => {
        'type': 'json',
        'schema': {
            'type': 'object',
            'properties': {
                'pracownicy': {
                    'type': 'array',
                    'items': {
                        'type': 'object',
                        'properties': {
                            'id': {'type': 'integer'},
                            'imie': {'type': 'string'},
                            'nazwisko': {'type': 'string'},
                            'pesel': {'type': 'string'},
                            'stanowisko': {'type': 'string'},
                            'wynagrodzenie': {'type': 'number'},
                            'data_zatrudnienia': {'type': 'string'},
                            'adres': {
                                'type': 'object',
                                'properties': {
                                    'ulica': {'type': 'string'},
                                    'miasto': {'type': 'string'},
                                    'kod_pocztowy': {'type': 'string'}
                                },
                                'required': ['ulica', 'miasto', 'kod_pocztowy']
                            }
                        },
                        'required': ['id', 'imie', 'nazwisko', 'pesel', 'stanowisko', 'wynagrodzenie', 'data_zatrudnienia', 'adres']
                    }
                },
                'podsumowanie': {
                    'type': 'object',
                    'properties': {
                        'liczba_rekordow': {'type': 'integer'},
                        'srednie_wynagrodzenie': {'type': 'number'},
                        'unikalne_miasta': {
                            'type': 'array',
                            'items': {'type': 'string'}
                        }
                    }
                }
            },
            'required': ['pracownicy', 'podsumowanie'],
            'additionalProperties': false
        }
    }
) AS dane_testowe;
