# index.rss.builder
xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Questions - SmartR"
    xml.description "Recent questions"
    xml.link formatted_questions_url(:rss)
    
    for question in @questions
      xml.item do
        xml.title question.name
        xml.description Sanitize.clean(BlueCloth.new(question.body).to_html,
            :elements => ['br','strong','ul','ol','blockquote','li','a','h1','h2','h3','p','span','pre','code','div','img'],
            :attributes =>{
              'a' => ['href','title'],
              'img' => ['src','title','alt']
            })
        xml.pubDate question.created_at.to_s(:rfc822)
        xml.link question_url(question)
        xml.guid question_url(question)
      end
    end
  end
end

