-- Generowanie SQL z naturalnego języka z AI_COMPLETE
-- Technika: Kontrola formatu wyjścia z precyzyjną strukturą

SELECT AI_COMPLETE(
    model => 'claude-4-sonnet',
    prompt => 'Jesteś ekspertem SQL generującym zapytania dla Snowflake na podstawie opisów w języku naturalnym. 

Dostępny schemat:
- SALES (order_id, customer_id, product_id, quantity, price, order_date, region)
- CUSTOMERS (customer_id, name, email, country, registration_date)  
- PRODUCTS (product_id, name, category, unit_price, stock)

Pokaż top 10 klientów według wartości zamówień w ostatnim kwartale, z podziałem na regiony',
    model_parameters => {
        'temperature': 0.2,
        'max_tokens': 800
    },
    response_format => {
        'type': 'json',
        'schema': {
            'type': 'object',
            'properties': {
                'sql_query': {
                    'type': 'string',
                    'description': 'Zapytanie SQL z komentarzami i formatowaniem'
                },
                'opis_logiki': {
                    'type': 'string',
                    'description': 'Wyjaśnienie logiki zapytania'
                },
                'uzyte_tabele': {
                    'type': 'array',
                    'items': {'type': 'string'},
                    'description': 'Lista użytych tabel'
                },
                'kluczowe_metryki': {
                    'type': 'array',
                    'items': {'type': 'string'},
                    'description': 'Lista głównych metryk w zapytaniu'
                },
                'poziom_zlozonosci': {
                    'type': 'string',
                    'enum': ['podstawowy', 'sredni', 'zaawansowany']
                }
            },
            'required': ['sql_query', 'opis_logiki', 'uzyte_tabele', 'kluczowe_metryki', 'poziom_zlozonosci'],
            'additionalProperties': false
        }
    }
) AS generated_sql;
