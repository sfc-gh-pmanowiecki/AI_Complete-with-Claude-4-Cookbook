-- Asystent inżynierii promptów AI
-- Technika: Meta-prompting - używanie AI do generowania optymalnych promptów dla innych zadań

-- Przykład 1: Podstawowe wywołanie asystenta prompt engineering
SELECT AI_COMPLETE(
    model => 'claude-4-sonnet',
    prompt => 'You are an expert AI prompt engineer. Your job is to help craft an optimized prompt for another AI assistant (like Claude) based on the user''s goal or task description. When the user provides a task description or goal, you will **generate a clear, structured prompt template** that the user can plug into an AI to achieve that goal. 

**Requirements for the generated prompt:**

- **Role Definition:** Begin by assigning the AI a relevant role or persona for the task (e.g. *"You are an experienced financial analyst..."*). This sets context.
- **Task Instructions:** Clearly explain the task and steps the AI should follow. Provide detailed instructions or step-by-step guidance if appropriate.
- **Chain-of-Thought/Scratchpad:** If complex reasoning is needed, include a scratchpad or reasoning section (e.g. in `<scratchpad>` tags) where the AI can brainstorm or work out the solution internally. *Example:* `In a <scratchpad>, list potential approaches...` 
- **Input Variables:** Use placeholders in double curly braces for any dynamic inputs the user will provide. Enclose larger inputs or important variables in descriptive XML-like tags to make the structure clear. *For example:*  
  `<customer_query>{{CUSTOMER_QUERY}}</customer_query>`  
  `The query language is {{LANGUAGE}}.` 
- **Output Format:** Specify the desired format of the AI''s output (e.g. `<analysis>...</analysis>` tags, bullet points, JSON, etc.) and any style guidelines.
- **Examples (if helpful):** Optionally include a brief example or format illustration (e.g. example input-output pairs or a template structure) to clarify expectations. Ensure any examples are clearly separated (for instance, in `<example>` tags).
- **Clarity and Conciseness:** The prompt itself should be well-organized and easy to follow, using tags or sections (like `<role>`, `<instructions>`, `<output_format>` etc.) for legibility. Avoid unnecessary words – be clear and direct.

Finally, output **only the prompt template** (formatted as described) and nothing else. Do not add explanations or additional commentary outside the prompt.

---

Please create an optimized prompt for: "I need help analyzing customer feedback and providing actionable business insights"',
    model_parameters => {
        'temperature': 0.3,
        'max_tokens': 2000
    }
) AS generated_prompt;

-- Przykład 2: Generowanie promptu dla konkretnego przypadku biznesowego
SELECT AI_COMPLETE(
    model => 'claude-4-sonnet', 
    prompt => 'You are an expert AI prompt engineer. Your job is to help craft an optimized prompt for another AI assistant (like Claude) based on the user''s goal or task description. When the user provides a task description or goal, you will **generate a clear, structured prompt template** that the user can plug into an AI to achieve that goal. 

**Requirements for the generated prompt:**

- **Role Definition:** Begin by assigning the AI a relevant role or persona for the task (e.g. *"You are an experienced financial analyst..."*). This sets context.
- **Task Instructions:** Clearly explain the task and steps the AI should follow. Provide detailed instructions or step-by-step guidance if appropriate.
- **Chain-of-Thought/Scratchpad:** If complex reasoning is needed, include a scratchpad or reasoning section (e.g. in `<scratchpad>` tags) where the AI can brainstorm or work out the solution internally. *Example:* `In a <scratchpad>, list potential approaches...` 
- **Input Variables:** Use placeholders in double curly braces for any dynamic inputs the user will provide. Enclose larger inputs or important variables in descriptive XML-like tags to make the structure clear. *For example:*  
  `<customer_query>{{CUSTOMER_QUERY}}</customer_query>`  
  `The query language is {{LANGUAGE}}.` 
- **Output Format:** Specify the desired format of the AI''s output (e.g. `<analysis>...</analysis>` tags, bullet points, JSON, etc.) and any style guidelines.
- **Examples (if helpful):** Optionally include a brief example or format illustration (e.g. example input-output pairs or a template structure) to clarify expectations. Ensure any examples are clearly separated (for instance, in `<example>` tags).
- **Clarity and Conciseness:** The prompt itself should be well-organized and easy to follow, using tags or sections (like `<role>`, `<instructions>`, `<output_format>` etc.) for legibility. Avoid unnecessary words – be clear and direct.

Finally, output **only the prompt template** (formatted as described) and nothing else. Do not add explanations or additional commentary outside the prompt.

---

Please create an optimized prompt for: "I need an AI that can help me write professional emails for different business scenarios (follow-ups, proposals, complaints, etc.)"',
    model_parameters => {
        'temperature': 0.3,
        'max_tokens': 2000
    }
) AS email_prompt_template;

-- Przykład 3: Generowanie promptu z JSON schema dla strukturyzowanych odpowiedzi
SELECT AI_COMPLETE(
    model => 'claude-4-sonnet',
    prompt => 'You are an expert AI prompt engineer. Your job is to help craft an optimized prompt for another AI assistant (like Claude) based on the user''s goal or task description. When the user provides a task description or goal, you will **generate a clear, structured prompt template** that the user can plug into an AI to achieve that goal. 

**Requirements for the generated prompt:**

- **Role Definition:** Begin by assigning the AI a relevant role or persona for the task (e.g. *"You are an experienced financial analyst..."*). This sets context.
- **Task Instructions:** Clearly explain the task and steps the AI should follow. Provide detailed instructions or step-by-step guidance if appropriate.
- **Chain-of-Thought/Scratchpad:** If complex reasoning is needed, include a scratchpad or reasoning section (e.g. in `<scratchpad>` tags) where the AI can brainstorm or work out the solution internally. *Example:* `In a <scratchpad>, list potential approaches...` 
- **Input Variables:** Use placeholders in double curly braces for any dynamic inputs the user will provide. Enclose larger inputs or important variables in descriptive XML-like tags to make the structure clear. *For example:*  
  `<customer_query>{{CUSTOMER_QUERY}}</customer_query>`  
  `The query language is {{LANGUAGE}}.` 
- **Output Format:** Specify the desired format of the AI''s output (e.g. `<analysis>...</analysis>` tags, bullet points, JSON, etc.) and any style guidelines.
- **Examples (if helpful):** Optionally include a brief example or format illustration (e.g. example input-output pairs or a template structure) to clarify expectations. Ensure any examples are clearly separated (for instance, in `<example>` tags).
- **Clarity and Conciseness:** The prompt itself should be well-organized and easy to follow, using tags or sections (like `<role>`, `<instructions>`, `<output_format>` etc.) for legibility. Avoid unnecessary words – be clear and direct.

Finally, output **only the prompt template** (formatted as described) and nothing else. Do not add explanations or additional commentary outside the prompt.

---

Please create an optimized prompt for: "I need an AI assistant that can analyze financial data and provide investment recommendations with risk assessment"',
    model_parameters => {
        'temperature': 0.2,
        'max_tokens': 2500
    }
) AS investment_prompt_template;

-- Wskazówki dotyczące użycia asystenta prompt engineering:
-- 1. Używaj niskiej temperature (0.2-0.3) dla spójnych i precyzyjnych promptów
-- 2. Dostarcz jasny opis zadania lub celu biznesowego
-- 3. Wygenerowany prompt można następnie używać z AI_COMPLETE dla konkretnych zadań
-- 4. Meta-prompting pozwala na iteracyjne doskonalenie promptów
-- 5. Wygenerowane prompty często zawierają placeholders do podstawienia danych
