interface AutocmdTypes {
  "LspAttach": [
    [{
      buf: number,
      data: {
        client_id: number
      },
    }],
    void
  ],
  "LspNotify": [
    [{
      buf: number,
      data: {
        client_id: number,
        method: string,
        params: unknown
      }
    }],
    void
  ]
}

export function useAutocmd<TKey extends keyof AutocmdTypes>(key: TKey, callback: (this: void, ...args: AutocmdTypes[TKey][0]) => AutocmdTypes[TKey][1]) {
  vim.api.nvim_create_autocmd(key as any, {
    callback: callback as any
  });
}
