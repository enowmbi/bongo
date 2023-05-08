xml.instruct! :xml, version: "1.0"
xml.rss version: "2.0" do
  xml.channel do
    xml.titlebegin
                Front.config.name
              rescue
                "My Blog"
              end
    xml.descriptionbegin
                      Front.config.description
                    rescue
                      "A bongo blog"
                    end
    xml.link root_url

    @articles.each do |article|
      xml.item do
        xml.title article.title
        xml.description ActionView::Base.full_sanitizer.sanitize(article.text).truncate(180)
        xml.pubDate article.publish_at.to_s(:rfc822)
        xml.link article_url(article)
        xml.guid article_url(article)
      end
    end
  end
end
