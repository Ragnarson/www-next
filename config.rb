###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
page "/*.xml", layout: false
page "/*.json", layout: false
page "/*.txt", layout: false

require "slim"

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

# General configuration

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

activate :sprockets

###
# Helpers
###

helpers do
  # Example usage:
  #
  #   image_set_tag_3x "foo_1x.png", alt: "foo"
  #
  # Will assume there is a 2x and 3x version and provide those automagically.
  #
  def image_set_tag_3x(source, options = {})
    srcset = [2, 3].map { |num|
      name = source.sub("_1x.", "_#{num}x.")
      "#{image_path(name)} #{num}x"
    }.join(", ")

    image_tag(source, options.merge(srcset: srcset))
  end

  def testimonial_image_tag(avatar)
    image_tag "project/testimonial/#{avatar}", class: "testimonial-avatar rounded-circle"
  end

  def logo_image_tag(logo)
    image_tag "project/logo/#{logo}"
  end

  def carousel_item_active(index)
    "active" if index.zero?
  end
end

# Build-specific configuration
configure :build do
  # Minify CSS on build
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript
end
