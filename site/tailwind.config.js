/** @type {import('tailwindcss').Config} */
module.exports = {
    /** This should be less broad :) */
    content: ["./**/*.html"],
    theme: {
      extend: {
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
