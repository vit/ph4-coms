module My
    class BreadcrumbsBuilder < BreadcrumbsOnRails::Breadcrumbs::SimpleBuilder
        def render_element(element)
            return super unless element.options[:dropdown]
            tag = @options[:tag] || 'span'
            @context.content_tag(tag,
                @context.link_to(compute_path(element), class: "bbtn bbtn-default bbtn-sm dropdown-toggle", data: {toggle: :dropdown}) do
                    (compute_name(element) + ' ' + @context.content_tag('i', "", class: "fa fa-caret-down")).html_safe
                end+
                @context.content_tag('ul',
                    element.options[:dropdown][:list].map do |item|
                        @context.content_tag('li',
                            @context.content_tag('a',
                                item[:text],
                                href: item[:path]
                            ),
                            class: (item[:active] ? 'active' : '')
                        )
                    end.join("").html_safe,
                    class: "dropdown-menu"
                ),
                class: 'dropdown', sstyle: 'display: block;'
            )
        end

    end
end
