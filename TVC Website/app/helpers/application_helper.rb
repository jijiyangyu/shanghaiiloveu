# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  unless const_defined?(:DEFAULT_OPTIONS)
    DEFAULT_OPTIONS = {
      :name => :page,
      :window_size => 2,
      :always_show_anchors => true,
      :link_to_current_page => false,
      :params => {}
    }
  end


  def pagination_link(paginator, options={}, html_options={})
    name = options[:name] || DEFAULT_OPTIONS[:name]
    params = (options[:params] || DEFAULT_OPTIONS[:params]).clone

    prefix = options[:prefix] || ''
    suffix = options[:suffix] || ''

    pagination_link_each(paginator, options, prefix, suffix) do |n|
      params[name] = n
      link_to(n.to_s, params, html_options)
    end
  end

  # Iterate through the pages of a given +paginator+, invoking a
  # block for each page number that needs to be rendered as a link.
  #
  # ==== Options
  # <tt>:window_size</tt>::          the number of pages to show around
  #                                  the current page (defaults to +2+)
  # <tt>:always_show_anchors</tt>::  whether or not the first and last
  #                                  pages should always be shown
  #                                  (defaults to +true+)
  # <tt>:link_to_current_page</tt>:: whether or not the current page
  #                                  should be linked to (defaults to
  #                                  +false+)
  #
  # ==== Example
  #  # Turn paginated links into an Ajax call
  #  pagination_links_each(paginator, page_options) do |link|
  #    options = { :url => {:action => 'list'}, :update => 'results' }
  #    html_options = { :href => url_for(:action => 'list') }
  #
  #    link_to_remote(link.to_s, options, html_options)
  #  end
  def pagination_link_each(paginator, options, prefix = nil, suffix = nil)
    options = DEFAULT_OPTIONS.merge(options)
    link_to_current_page = options[:link_to_current_page]
    always_show_anchors = options[:always_show_anchors]

    current_page = paginator.current_page
    window_pages = current_page.window(options[:window_size]).pages
    return if window_pages.length <= 1 unless link_to_current_page

    first, last = paginator.first, paginator.last

    html = ''

    html << prefix if prefix

    if always_show_anchors and not (wp_first = window_pages[0]).first?
      html << "<li>"
      html << yield(first.number)
      html << ' ... ' if wp_first.number - first.number > 1
      html << '</li>'
    end

    window_pages.each do |page|
      if current_page == page && !link_to_current_page
        html << "<li><a class='sb_pagS'>"
        html << page.number.to_s
        html << "</a>"
      else
        html << "<li>"
        html << yield(page.number)
      end
      html << '</li>'
    end

    if always_show_anchors and not (wp_last = window_pages[-1]).last?
      html << "<li>"
      html << ' ... ' if last.number - wp_last.number > 1
      html << yield(last.number)
      html << '</li>'
    end

    html << suffix if suffix

    html
  end
end
