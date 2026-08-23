return {
  "yetone/avante.nvim",

  build = vim.fn.has("win32") ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
    or "make",

  event = "VeryLazy",
  version = false,

  ---@module 'avante'
  ---@type avante.Config
  opts = {
    instructions_file = "avante.md",

    -- LOCAL OLLAMA
    provider = "ollama",
    providers = {
      ollama = {
        endpoint = "http://127.0.0.1:11434",
        -- model = "qwen3-coder:30b",
        model = "qwen3:8b",
      },
    },

    -- CHATGPT
    -- provider = "openai",
    -- providers = {
    --   openai = {
    --     endpoint = "https://api.openai.com/v1",
    --     model = "gpt-4o-mini",
    --     api_key_name = "OPENAI_API_KEY", -- Automatically reads env
    --     timeout = 30000,
    --     extra_request_body = {
    --       temperature = 0.7,
    --       max_tokens = 8192,
    --     },
    --   },
    -- },

    -- GEMINI LEAGUE
    -- provider = "league_vertexai",
    --
    -- vendors = {
    --   ---@type AvanteProvider
    --   ["league_vertexai"] = {
    --     endpoint = "https://us-central1-aiplatform.googleapis.com/v1/projects/league-internal-genai/locations/us-central1/publishers/google/models",
    --     model = "gemini-1.5-flash-002",
    --     api_key_name = "cmd:gcloud auth print-access-token",
    --
    --     -- ✅ tell avante we *do* support streaming
    --     is_disable_stream = function()
    --       return false
    --     end,
    --
    --     -- ✅ your curl args (with our earlier fix still intact)
    --     parse_curl_args = function(opts, code_opts)
    --       -- local debug if you need it:
    --       -- vim.print("--- DEBUGGING code_opts ---")
    --       -- vim.print(code_opts)
    --       -- vim.print("---------------------------")
    --
    --       local body_opts = vim.tbl_deep_extend("force", {}, {
    --         generationConfig = {
    --           temperature = 0,
    --           maxOutputTokens = 4096,
    --         },
    --       })
    --
    --       local provider_instance = require("avante.providers.gemini")
    --
    --       local function safe_parse_messages(prompt_opts)
    --         local ok, parsed = pcall(function()
    --           -- NOTE: ':' so provider_instance is passed as self
    --           return provider_instance:parse_messages(prompt_opts)
    --         end)
    --
    --         if not ok or not parsed or vim.tbl_isempty(parsed) then
    --           return { contents = {} }
    --         end
    --
    --         return parsed
    --       end
    --
    --       return {
    --         url = opts.endpoint .. "/" .. opts.model .. ":streamGenerateContent?alt=sse",
    --         headers = {
    --           ["Authorization"] = "Bearer " .. opts.parse_api_key(),
    --           ["Content-Type"] = "application/json; charset=utf-8",
    --         },
    --         body = vim.tbl_deep_extend("force", {}, safe_parse_messages(code_opts), body_opts),
    --       }
    --     end,
    --
    --     -- ✅ use parse_response for custom vendors (not parse_response_data)
    --     parse_response = function(data_stream, event_state, opts)
    --       require("avante.providers.gemini").parse_response(data_stream, event_state, opts)
    --     end,
    --   },
    -- },

    -- (rest of your opts unchanged)
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-mini/mini.pick",
      "nvim-telescope/telescope.nvim",
      "hrsh7th/nvim-cmp",
      "ibhagwan/fzf-lua",
      "stevearc/dressing.nvim",
      "folke/snacks.nvim",
      "nvim-tree/nvim-web-devicons",
      "zbirenbaum/copilot.lua",
      {
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            use_absolute_path = true,
          },
        },
      },
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
      {
        "Kaiser-Yang/blink-cmp-avante",
        lazy = true,
        specs = {
          {
            "saghen/blink.cmp",
            optional = true,
            opts = {
              sources = {
                default = { "avante" },
                providers = { avante = { module = "blink-cmp-avante", name = "Avante" } },
              },
            },
          },
        },
      },
      {
        "MeanderingProgrammer/render-markdown.nvim",
        optional = true,
        ft = function(_, ft)
          vim.list_extend(ft, { "Avante" })
        end,
        opts = function(_, opts)
          opts.file_types = vim.list_extend(opts.file_types or {}, { "Avante" })
        end,
      },
      {
        "folke/which-key.nvim",
        optional = true,
        opts = {
          spec = {
            { "<leader>a", desc = "avante" },
          },
        },
      },
    },
  },
}
