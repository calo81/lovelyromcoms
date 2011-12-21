Given /^(?:|I )am on (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^user can see (["]{1}([a-zA-Z ]+)["]{1}) text in the page$/ do |text_quoted,text|
  page.has_content?(text).should be_true
end