-- Klasyfikacja produktów z AI_COMPLETE
-- Technika: Few-shot Learning - dostarczenie przykładów oczekiwanego formatu

SELECT AI_COMPLETE(
    model => 'claude-4-sonnet',
    prompt => 'Jesteś ekspertem w klasyfikacji produktów. Analizuj produkty i przypisuj im odpowiednie kategorie oraz tagi.

Przykłady:

iPhone 15 Pro Max 256GB:
{
  "produkt": "iPhone 15 Pro Max 256GB",
  "kategoria": "Elektronika",
  "podkategoria": "Smartfony",
  "tagi": ["Apple", "iOS", "5G", "Premium", "Fotografia"]
}

Adidas Ultraboost 22 męskie rozmiar 42:
{
  "produkt": "Adidas Ultraboost 22 męskie rozmiar 42",
  "kategoria": "Odzież i Obuwie",
  "podkategoria": "Obuwie sportowe",
  "tagi": ["Adidas", "Bieganie", "Męskie", "Boost", "Performance"]
}

Teraz sklasyfikuj: Samsung QLED 65" 4K Smart TV',
    model_parameters => {
        'temperature': 0.2,
        'max_tokens': 200
    },
    response_format => {
        'type': 'json',
        'schema': {
            'type': 'object',
            'properties': {
                'produkt': {
                    'type': 'string',
                    'description': 'Nazwa produktu'
                },
                'kategoria': {
                    'type': 'string',
                    'description': 'Główna kategoria produktu'
                },
                'podkategoria': {
                    'type': 'string',
                    'description': 'Szczegółowa podkategoria'
                },
                'tagi': {
                    'type': 'array',
                    'items': {'type': 'string'}
                },
                'poziom_premium': {
                    'type': 'string',
                    'enum': ['podstawowy', 'sredni', 'premium', 'luksusowy'],
                    'description': 'Poziom premium produktu'
                }
            },
            'required': ['produkt', 'kategoria', 'podkategoria', 'tagi', 'poziom_premium'],
            'additionalProperties': false
        }
    }
) AS klasyfikacja;
