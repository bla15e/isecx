+++
title = "Building the Website :babel:hugo:webdev"
author = ["Blaise"]
summary = "Hacking on a Hugo Theme"
date = 2024-04-03T21:09:28-04:00
draft = false
+++

This is how we confiugre our project to use the Hugo static site builder.


## Configuration: Hugo {#configuration-hugo}

<a id="code-snippet--hugo-toml"></a>
```scheme
baseURL = 'https://ise.cx'
languageCode = 'en-us'
title = 'isecx'
theme = "../../../ap-lit"

[markup.goldmark.renderer]
  unsafe = true
```


## Configuration: Tailwind &amp; node {#configuration-tailwind-and-node}

<a id="code-snippet--site-package-json"></a>
```json
{
  "name": "ap-lit-hugo-theme",
  "version": "1.0.0",
  "description": "Literate Blog for Isecx",
  "main": "index.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "author": "",
  "license": "ISC",
  "devDependencies": {
    "@tailwindcss/typography": "^0.5.12",
    "tailwindcss": "^3.3.3"
  }
}
```

<a id="code-snippet--site-tailwind-config-js"></a>
```javascript
/** @type {import('tailwindcss').Config} */
module.exports = {
    /** This should be less broad :) */
    content: ["./**/*.html"],
    theme: {
      extend: {
        animation: {
          'fadeIn': 'fadeIn 0.5s ease-in forwards'
        },
        colors: {
          brand: {
            50: "#FFFBF5",
            100: "#FFF4E5",
            200: "#FFE7C7",
            300: "#FFD9A8",
            400: "#FFCA85",
            500: "#FFB75A",
            600: "#FF9C1A",
            700: "#EB8500",
            800: "#C26E00",
            900: "#8A4E00",
            950: "#663A00"
          }
        }
      },
    },
    plugins: [require('@tailwindcss/typography')],
  }
```
