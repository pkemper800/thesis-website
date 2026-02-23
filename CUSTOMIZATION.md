# Customization Guide

This guide shows you how to customize your thesis website.

## 🎨 Visual Customization

### 1. Change Colors

Edit `custom.scss`:

```scss
/*-- scss:defaults --*/

$primary: #1a365d;     // Main brand color (dark blue)
$secondary: #38b2ac;   // Accent color (teal)
$success: #48bb78;     // Success messages (green)
$warning: #ed8936;     // Warnings (orange)
$danger: #f56565;      // Errors (red)
```

**Color Palette Ideas:**
- Academic Blue: `#003366` (primary), `#0066cc` (secondary)
- Forest Green: `#2d5016` (primary), `#6ba539` (secondary)
- Professional Purple: `#5b21b6` (primary), `#8b5cf6` (secondary)
- Warm Earth: `#78350f` (primary), `#d97706` (secondary)

### 2. Change Fonts

Edit `custom.scss`:

```scss
// Google Fonts import (add to top of file)
@import url('https://fonts.googleapis.com/css2?family=Merriweather:wght@400;700&family=Open+Sans:wght@400;600&display=swap');

$font-family-sans-serif: "Open Sans", system-ui, sans-serif;
$headings-font-family: "Merriweather", serif;
```

**Font Pairing Ideas:**
- Classic Academic: Merriweather (headings) + Open Sans (body)
- Modern Clean: Poppins (headings) + Inter (body)
- Editorial: Playfair Display (headings) + Source Sans Pro (body)
- Tech/Data: IBM Plex Sans (headings) + IBM Plex Mono (code)

### 3. Change Theme

Edit `_quarto.yml`:

```yaml
format:
  html:
    theme: 
      light: [flatly, custom.scss]
      dark: [darkly, custom.scss]
```

**Available Themes:**
- **Light**: cosmo, flatly, journal, litera, lumen, minty, pulse, sandstone, simplex, yeti
- **Dark**: darkly, slate, solar, superhero, vapor, cyborg

Try different combinations!

## 📐 Layout Customization

### Full-Width Pages

For wide content (maps, large visualizations), add to page YAML:

```yaml
---
title: "My Wide Page"
page-layout: full
---
```

Options: `article` (default), `full`, `custom`

### Custom Homepage Layout

Edit `index.qmd` to create a custom hero section:

```markdown
---
title: "My Research"
page-layout: custom
---

::: {.hero-section style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 4rem 2rem; color: white; text-align: center; border-radius: 8px;"}

# Your Research Title

*Subtitle or tagline here*

[Get Started](research/index.qmd){.btn .btn-light .btn-lg}

:::
```

### Two-Column Layout

```markdown
::: {.grid}

::: {.g-col-6}
## Left Column
Content here...
:::

::: {.g-col-6}
## Right Column
Content here...
:::

:::
```

## 🔧 Functional Customization

### Add Google Analytics

Edit `_quarto.yml`:

```yaml
website:
  google-analytics: "G-XXXXXXXXXX"
```

### Add Comment System (Giscus)

Add to `_quarto.yml`:

```yaml
website:
  comments:
    giscus:
      repo: yourusername/thesis-website
```

### Add Social Media Cards

Edit `_quarto.yml`:

```yaml
website:
  twitter-card: true
  open-graph: true
  image: images/og-image.png
```

### Custom Footer

Edit `_quarto.yml`:

```yaml
website:
  page-footer:
    left: "© 2024 Your Name"
    right: 
      - icon: github
        href: https://github.com/yourusername
      - icon: twitter
        href: https://twitter.com/yourusername
```

## 📊 Code Customization

### Set Global Code Options

Edit `_quarto.yml`:

```yaml
execute:
  echo: true        # Show code by default
  warning: false    # Hide warnings
  message: false    # Hide messages
  cache: true       # Cache results for faster rendering
```

### Custom Code Highlighting

Edit `_quarto.yml`:

```yaml
format:
  html:
    highlight-style: github  # Options: github, atom-one, dracula, monokai, etc.
```

### Add Line Numbers to Code

In page YAML or globally:

```yaml
format:
  html:
    code-line-numbers: true
```

## 🗂️ Navigation Customization

### Add Dropdown Menu

Edit `_quarto.yml`:

```yaml
navbar:
  left:
    - text: "Resources"
      menu:
        - text: "Data Sources"
          href: resources/data.qmd
        - text: "Code Repository"
          href: resources/code.qmd
        - text: "Publications"
          href: resources/publications.qmd
```

### Multiple Sidebars

For different sections:

```yaml
website:
  sidebar:
    - id: research
      title: "Research"
      contents:
        - research/*.qmd
    
    - id: methods
      title: "Methods"
      contents:
        - methods/*.qmd
```

Reference in pages:

```yaml
---
sidebar: research
---
```

## 🎯 Advanced Customization

### Custom CSS Classes

Add to `styles.css`:

```css
.highlight-box {
  background-color: #fff3cd;
  border-left: 4px solid #ffc107;
  padding: 1rem;
  margin: 1rem 0;
}

.data-badge {
  display: inline-block;
  padding: 0.25rem 0.5rem;
  background: #007bff;
  color: white;
  border-radius: 4px;
  font-size: 0.875rem;
}
```

Use in pages:

```markdown
::: {.highlight-box}
Important information here!
:::

Data from 2024 [Updated]{.data-badge}
```

### Custom JavaScript

Create `custom.js`:

```javascript
// Add smooth scroll
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
  anchor.addEventListener('click', function (e) {
    e.preventDefault();
    document.querySelector(this.getAttribute('href')).scrollIntoView({
      behavior: 'smooth'
    });
  });
});
```

Include in `_quarto.yml`:

```yaml
format:
  html:
    include-after-body: custom.js
```

### Custom Shortcodes

Create reusable content:

In `_extensions/`:

```lua
-- callout-thesis.lua
function Div(el)
  if el.classes:includes('thesis-note') then
    return {
      pandoc.RawBlock('html', '<div class="thesis-callout">'),
      el,
      pandoc.RawBlock('html', '</div>')
    }
  end
end
```

## 🖼️ Adding Images and Media

### Banner Images

```yaml
---
title: "My Page"
image: images/banner.jpg
---
```

### Figure with Caption

```markdown
![Map showing study area](images/study-area.png){#fig-study-area}

See @fig-study-area for the study location.
```

### Embedded Videos

```markdown
{{< video https://www.youtube.com/watch?v=VIDEO_ID >}}
```

## 💡 Quick Tips

1. **Preview changes live**: Run `quarto preview` and edit files - the site auto-refreshes
2. **Test before deploying**: Always run `quarto render` locally first
3. **Use version control**: Commit often with clear messages
4. **Keep it simple**: Start minimal and add complexity as needed
5. **Check mobile**: Test your site on mobile devices

## 🔍 Troubleshooting

**Colors not changing?**
- Clear browser cache
- Check SCSS syntax (missing semicolons?)
- Ensure custom.scss is listed in `_quarto.yml`

**Fonts not loading?**
- Verify Google Fonts URL
- Check browser console for errors
- Ensure proper font name spelling

**Layout broken?**
- Validate YAML indentation
- Check div closing tags
- Look for unclosed code blocks

## 📚 More Resources

- [Quarto Theme Reference](https://quarto.org/docs/output-formats/html-themes.html)
- [Bootstrap Color System](https://getbootstrap.com/docs/5.1/customize/color/)
- [Google Fonts](https://fonts.google.com/)
- [Font Pairing Guide](https://fontpair.co/)

---

**Experiment and have fun!** The best way to learn is to try things and see what works for your research aesthetic.
