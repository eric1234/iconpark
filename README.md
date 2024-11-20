# Rails Iconpark Integration

A small gem to integrate [Iconpark](https://iconpark.oceanengine.com/home) with
the Ruby on Rails asset pipeline. Tested with
[propshaft](https://github.com/rails/propshaft) but it should work with
[sprockets](https://github.com/rails/sprockets-rails).

**WARNING** - This gem is a work in progress and has only been used in a very
limited way. Unless you want to be involved in developing it, wait until this
message is removed as everything is subject to change and things may break.

## Why Iconpark?

I wanted to put a brief message about why you should consider using Iconpark.
There are a lot of good icon sets out there. Why this one?

The biggest advantages are:

* It's a large icon set. This is important as it gives you more choices in
  choosing just the right icon to convey a concept. We've all had the trouble
  of not having just the right icon and when that happens it defeats the purpose
  of even using an icon. The larger the icon set the more likely you can avoid
  this problem.
* It is fully customizable with 4 "themes" (style) as well a full customization
  of colors, stroke width, cap and join types resulting in almost endless
  possibilities in style instead of being confined to pre-baked styles.

A few comparisons to the biggest competitors:

* [FontAwesome](https://fontawesome.com) - Although it looks impressive at
  53K icons and counting. But many of those are the same icons but with just
  different styles applied. Unique icons is about 13K. But now also many of
  those require a license. If we just look at the free options we are down to
  around 1,500 and you cannot use most of the customized versions, just the
  classic style. Iconpark is 2658 icons and all are fully customizable.
* [Boostrap Icons](https://icons.getbootstrap.com/) - They claim about 2K icons
  but many of them are just "fill" versions of another icon (which is just a
  point of customization in Iconpark). Unique icons are probably somewhere
  between 1200-1500. Also the customization is very limited to just a "fill"
  version for some icons and color customization only through currentcolor.
* [heroicons](https://heroicons.com/) - By the makers of Tailwind and often used
  with Tailwind. A very small iconset of only 316 with limited customized
  versions of each icon.

The final reason is that Iconpark is at this time not widely used so at least
for now your app won't look like every other app.

## Installation

Install the gem and add to the application's Gemfile by executing:

```sh
bundle add iconpark
```

Then add `iconpark.css` to your CSS. With propshaft, you can just add the
following to your `application.css` file.

```css
@import url("iconpark.css")
```

## Usage

To place an icon on a page, use the `icon` helper. Any of the icons available
in iconpark will work. Just the name is needed. You can leave off the SVG
extension. So:

```erb
<%= icon 'save' %>
```

This will place the "save" icon on the page. It is placed on the page using the
[SVG `use` element](https://developer.mozilla.org/en-US/docs/Web/SVG/Element/use).
This gives both the advantages of inline SVG (style-able with CSS) with the
advantages of an `img` tag (cached).

### Theming

One of the big reasons for using iconpark is the customization allowed with
iconpark. On their website you can customize the:

* **theme** - outline (default), filled, two-tone, multi-color
* **colors**
* **stroke width** - default 4
* **line cap type** - butt, round (default), square
* **line join type** - miter, round (default), bevel

This integration lets you customize most of these factors via CSS variables. If
you do no customization and don't even use the provided CSS file, then the icons
will display with the above indicated defaults. The color will be
"currentcolor" (i.e. text color).

The included CSS file provides two things:

* A set of classes to be able to chose the icon theme.
* A set of custom CSS properties for the other customizations.

When including the icon on the page you choose the theme with the `theme` named
parameter. For example:

```erb
<%= icon 'save', theme: 'two-tone' %>
```

You can override the default theme (theme used when not specified in to the
`icon` helper) by adding the following to an initializer:

```ruby
Iconpark.default_theme = 'two-tone'
```

For all other customization is done via custom CSS properties:

* `--iconpark-stroke-width`
* `--iconpark-stroke-line-cap`
* `--iconpark-stroke-line-join`

The colors CSS properties depend on what theme you are using.

* `outline`
  * `--iconpark-stroke-color` - Defaults to `currentcolor`
* `filled`
  * `--iconpark-stroke-color` - Default to `currentcolor`
* `two-tone`
  * `--iconpark-stroke-color` - Defaults to `currentcolor`
  * `--iconpark-fill-color` - Defaults to 40% alpha of stroke color
* `multi-color`
  * `--iconpark-stroke-color` - Defaults to `currentcolor`
  * `--iconpark-fill-color` - Defaults to 40% alpha of stroke color
  * `--iconpark-inner-stroke-color` - Defaults to 50% blacker than `currentcolor`
  * `--iconpark-outer-fill-color` - Defaults to 70% whiter than `currentcolor`

## Development

After checking out the repo, run `bin/setup` to install dependencies. To install
this gem onto your local machine, run `bundle exec rake install`.

To release a new version:

1. Update the version number in `version.rb`
2. Run `rake release`. This will:
    * Ensure the icons are imported for packaging.
    * Create a git tag for the version.
    * Push git commits and the created tag.
    * Push the `.gem` file to [rubygems.org](https://rubygems.org).

The actual icons are purposely not part of this repo and just bundled with
the packaged gem. The rake task `icon_import` will generate the latest icons
and this is auto-run with the above `release` task. A impl of node is assumed
on the developer machine although it is not needed for people using this
package.

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/eric1234/iconpark.

## License

Although this software is released to the public domain (see the
[UNLICENSE](UNLICENSE) file), the icons in Iconpark themselves are licensed
under the Apache license.
