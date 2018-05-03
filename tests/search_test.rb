require 'selenium-webdriver'

class Test

require_relative '../lib/env'
require_relative '../lib/page_objects/search_results_page'
require_relative '../lib/page_objects/index_page'
require_relative '../lib/page_objects/freelancer_page'

search_term = 'Test'

run {
  index = IndexPage.new(@driver)
  index.search_for search_term
  results = SearchResultsPage.new(@driver)
  results.get_freelancers_info
  results.freelancers_has_value? search_term
  results.open_random_freelancer
  freelancer_page = FreelancerPage.new(@driver)
  freelancer_page.get_freelancer_data

  freelancer_page.is_freelancer_data_equal?.equal? true
}

end

