-- Podstawowa struktura wywołania AI_COMPLETE
-- Przykład pokazuje podstawowy sposób używania nowej funkcji AI z modelami Claude 4

-- Składnia z pojedynczym stringiem (ZALECANA dla response_format)
SELECT AI_COMPLETE(
    model => 'claude-4-sonnet',
    prompt => 'Jesteś pomocnym asystentem AI. Odpowiedz na pytanie użytkownika w sposób jasny i precyzyjny: Jak działa sztuczna inteligencja?',
    model_parameters => {
        'temperature': 0.7,
        'max_tokens': 1000
    }
) AS response;
