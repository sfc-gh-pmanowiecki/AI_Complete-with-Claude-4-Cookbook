-- Analiza sentymentu z JSON Schema
-- Technika: Strukturyzowane odpowiedzi z AI_COMPLETE response_format

SELECT AI_COMPLETE(
    model => 'claude-4-sonnet',
    prompt => 'Jesteś ekspertem analizy sentymentu. Przeanalizuj sentyment dla następującej opinii, zwracając wynik w formacie JSON z kategoriami sentymentu: "Produkt przekroczył moje oczekiwania! Szybka dostawa, świetna jakość wykonania. Jedyny minus to trochę wysoka cena, ale warto."',
    model_parameters => {
        'temperature': 0.1,
        'max_tokens': 500
    },
    response_format => {
        'type': 'json',
        'schema': {
            'type': 'object',
            'properties': {
                'sentiment_categories': {
                    'type': 'object',
                    'properties': {
                        'product_quality': {'type': 'string'},
                        'delivery_speed': {'type': 'string'},
                        'price_value': {'type': 'string'},
                        'overall': {'type': 'string'}
                    },
                    'required': ['product_quality', 'delivery_speed', 'price_value', 'overall']
                }
            }
        }
    }
) AS analiza_sentymentu;
