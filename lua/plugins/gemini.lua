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
        'GeminiCodeReivew',
        'GeminiCodeExplain',
        'GeminiFunctionHint',
    }
}

return { gemini }
