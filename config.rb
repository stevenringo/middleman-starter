set :markdown_engine, :redcarpet
set :markdown, fenced_code_blocks: true, smartypants: true, lax_spacing: true

set :haml, format: :html5
set :sass, line_comments: false, style: :nested

set :css_dir,    'stylesheets'
set :js_dir,     'javascripts'
set :images_dir, 'images'

set :layout, "layouts/default"

activate :blog do |blog|
  blog.sources = "posts/:year-:month-:day-:title."
  blog.permalink = "posts/:year/:month/:day/:title.html"
  blog.summary_separator = /(READMORE)/
  blog.summary_length = 250
  blog.layout = "layouts/blog"
  blog.default_extension = "erb.md"
  blog.paginate = true
  blog.per_page = 3
  blog.page_link = "page/:num"
end

Time.zone = "Sydney"

activate :directory_indexes
activate :syntax
activate :livereload

page "/feed.xml", layout: false

configure :build do
  set :sass, style: :compressed
  activate :asset_hash, :exts => ['.css']

  activate :asset_host
  set :asset_host, "http://assets.the_cloud.com"
end

helpers do
  def page_title
    title = data.page.heading ? "#{data.page.heading}" : "Just Another Site"
    strip_tags(title)
  end

  def obfuscated_email
    "&#105;&#110;&#102;&#111;&#064;&#101;&#120;&#097;&#109;&#112;&#108;&#101;&#046;&#099;&#111;&#109;"
  end

  def image_with_caption(image, caption)
    template = ERB.new <<-eos
<figure class="figure">
  <%= image_tag image, alt: caption, title: caption %>
  <figcaption class="figure-caption"><%= caption %></figcaption>
</figure>
    eos
    template.result(binding)
  end

end
