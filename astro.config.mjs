import { defineConfig } from 'astro/config';
import tailwindcss from '@tailwindcss/vite';
import sitemap from '@astrojs/sitemap';

export default defineConfig({
  site: 'https://mobile.dawin.co.jp',
  integrations: [sitemap({ filter: (page) => !page.includes('/thanks') })],
  vite: {
    plugins: [tailwindcss()],
    server: {
      allowedHosts: ['operate-luridness-graceful.ngrok-free.dev'],
    },
  },
});
