return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = { "echasnovski/mini.nvim" },
        opts = {},
        config = function()
            require("render-markdown").setup({})
        end,
    },
}
