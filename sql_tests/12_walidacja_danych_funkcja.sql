-- Walidacja formatu danych z AI_COMPLETE
-- Technika: Funkcja z zaawansowaną walidacją i normalizacją

USE DATABASE STREAMLIT_DB;
USE SCHEMA PUBLIC;

CREATE OR REPLACE FUNCTION VALIDATE_AND_PROCESS(input_data VARIANT)
RETURNS VARIANT
LANGUAGE SQL
AS
$$
SELECT AI_COMPLETE(
    model => 'claude-4-sonnet',
    prompt => 'Jesteś walidatorem danych z ekspertyzą w polskich formatach i standardach biznesowych.

Zwaliduj dane: ' || input_data::STRING,
    model_parameters => {
        'temperature': 0.1,
        'max_tokens': 1000
    },
    response_format => {
        'type': 'json',
        'schema': {
            'type': 'object',
            'properties': {
                'status_walidacji': {
                    'type': 'object',
                    'properties': {
                        'jest_poprawny': {'type': 'boolean'},
                        'poziom_pewnosci': {'type': 'integer'},
                        'czas_walidacji': {'type': 'string'}
                    }
                },
                'bledy': {
                    'type': 'array',
                    'items': {
                        'type': 'object',
                        'properties': {
                            'pole': {'type': 'string'},
                            'rodzaj_bledu': {
                                'type': 'string',
                                'enum': ['format', 'zakres', 'wymagane', 'typ', 'logika']
                            },
                            'opis': {'type': 'string'},
                            'sugerowana_poprawka': {'type': 'string'}
                        }
                    }
                },
                'ostrzezenia': {
                    'type': 'array',
                    'items': {'type': 'string'}
                },
                'dane_po_czyszczeniu': {
                    'type': 'object'
                },
                'statystyki': {
                    'type': 'object',
                    'properties': {
                        'liczba_pol': {'type': 'integer'},
                        'poprawne_pola': {'type': 'integer'},
                        'procent_poprawnosci': {'type': 'number'}
                    }
                }
            },
            'required': ['status_walidacji', 'bledy', 'ostrzezenia', 'dane_po_czyszczeniu', 'statystyki'],
            'additionalProperties': false
        }
    }
)::VARIANT
$$;

-- Przykład użycia funkcji
SELECT VALIDATE_AND_PROCESS(
    {
        'imie': 'Jan',
        'nazwisko': 'Kowalski', 
        'email': 'invalid-email',
        'telefon': '123',
        'pesel': '12345678901'
    }
) AS wynik_walidacji;
