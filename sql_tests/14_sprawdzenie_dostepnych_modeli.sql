-- Sprawdzenie dostępnych modeli AI_COMPLETE
-- Test czy cross-region inference jest włączone dla Claude

SELECT AI_COMPLETE(
    model => 'claude-4-sonnet',
    prompt => 'Hello! If you can see this, Claude 4 Sonnet is available in this Snowflake account.',
    model_parameters => {
        'temperature': 0.1,
        'max_tokens': 100
    }
) AS model_test;

-- Informacje o dostępnych modelach w AI_COMPLETE:
-- claude-4-opus      - Najbardziej zaawansowany (obsługuje tekst i obrazy)
-- claude-4-sonnet    - Zbalansowany model (główny, obsługuje tekst i obrazy)
-- claude-3-7-sonnet  - Ulepszona wersja Claude 3.5
-- claude-3-5-sonnet  - Model poprzedniej generacji
-- deepseek-r1        - Nowy model z zaawansowanym rozumowaniem
-- llama3.3-70b       - Najnowszy model Llama
-- A także inne modele: gemma, jamba, mistral, reka, snowflake-arctic

-- Sprawdzenie funkcji AI_COMPLETE
SHOW FUNCTIONS LIKE 'AI_COMPLETE';
