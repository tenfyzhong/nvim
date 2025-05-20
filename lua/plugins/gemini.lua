local gemini = {
    'kiddos/gemini.nvim',
    opts = {
        completion = {
            enabled = false
        }
    },
    cmd = {
        'GeminiChat',
        'GeminiTask',
        'GeminiApply',
        'GeminiUnitTest',
        'GeminiCodeReview',
        'GeminiCodeExplain',
        'GeminiFunctionHint',
    }
}

return { gemini }
