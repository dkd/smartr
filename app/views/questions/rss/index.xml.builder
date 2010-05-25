# index.rss.builder
xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0", "xmlns:dc" => "http://purl.org/dc/elements/1.1/" do
  xml.channel do
    xml.title "Questions - #{request.host}"
    
    xml.description "Recent questions"
    xml.link formatted_questions_url(:xml)
    xml.copyright Settings.copyright
    
    for question in @questions
      xml.item do
        xml.tag!("dc:creator", question.user.login)
        xml.title question.name
        xml.description code(question.body)
        xml.pubDate question.created_at.to_s(:rfc822)
        xml.link question_url(question)
        xml.guid question_url(question)
        question.tags.each do |tag| 
                              xml.category tag
                            end
      end
    end
  end
end

