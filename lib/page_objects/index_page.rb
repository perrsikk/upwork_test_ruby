require_relative '../../lib/env'
require_relative '../../lib/base'

class IndexPage < Base

  SEARCH_BOX = { css: 'input[data-qa="s_input"]' }
  BANNER = { class: 'ee-hero-section' }

  def initialize(driver)
    super
    visit
    verify_page
  end

  def search_for(search_term)
    type SEARCH_BOX, search_term
    submit SEARCH_BOX
  end

  private

  def verify_page
    page_loaded?
    wait_for { displayed?(BANNER) }
  end
end