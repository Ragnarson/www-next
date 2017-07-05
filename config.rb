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

# @app.data is a workaround to get an actual array of data within config.rb
case_studies = @app.data["case-studies"]
case_studies.each_with_index do |case_study, index|
  proxy "/case-studies/#{case_study["slug"]}.html",
        "/case-study.html",
        locals: {
          case_study: case_study,
          next_case_study: case_studies[(index + 1) % case_studies.size],
          previous_case_study: case_studies[index - 1]
        },
        ignore: true
end

# General configuration

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

activate :sprockets

# Cloudflare adds a 4 hour cache to all assets by default, which we don't want for
# files like the how we work PDF, and we want even longer times for assets with a hash.
#
# There's no way to use a regex in Cloudflare's Page Rules, so a simple workaround is to add
# this -c0 prefix to the hash, which is unlikely to appear in any other file name.
# Then we configure Cloudflare to cache files matching *-c0*.* for a month, and remove caching
# for all other assets.
activate :asset_hash, prefix: "c0"

activate :directory_indexes

set :url_root, "https://ragnarson.com"
activate :search_engine_sitemap

activate :twitter_oembed do |twitter|
  twitter.cache_dir = ".cache/"
end

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

  def case_study_image_tag(name, options = {})
    image_tag "case-studies/#{name}", options
  end

  def case_study_summary(summary)
    if summary.length < 260
      summary
    else
      "#{summary[0..260]}..."
    end
  end

  def case_study_path(case_study)
    "/case-studies/#{case_study["slug"]}.html"
  end

  def carousel_item_active(index)
    "active" if index.zero?
  end

  def find_project(project_id)
    result = data["projects"].select { |record| record["id"] == project_id }
    result.any? ? result.first : nil
  end

  def case_study_style(case_study)
    color_start = case_study["color-start"]
    color_end = case_study["color-end"]

    if color_start && color_end
      "background-image: linear-gradient(to top, #{color_start}, #{color_start} 40%, #{color_end});"
    end
  end

  def code_example
    data["code-example"]
  end

  def sitemap_description
    data["sitemap-description"]
  end
end

configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :autoprefixer
end

activate :deploy do |deploy|
  deploy.build_before = true
  deploy.deploy_method = :git
  deploy.strategy = :force_push
end
