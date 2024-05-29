class RecipeSearchService
  DEFAULT_PAGE_SIZE = 25

  # params should be of the form:
  # {
  #   'page'      => (number)  # Optional. Defaults to `1`. Will be limited to valid bounds
  #   'page_size' => (number)  # Optional. Defaults to `DEFAULT_PAGE_SIZE`. Will
  #                            # be limited to positive numbers
  #   'search'    => (string)  # Optional. Ignored if blank.
  #   'sort_by'   => (string)  # Optional. Sorts by 'name ASC' if specified as "name",
  #                            # defaults to `created_at DESC` otherwise.
  # }
  def initialize(params = {})
    @params = params
  end

  def call
    @recipes = Recipe.all

    search!
    sort!

    @total = @recipes.count

    paginate!

    {
      'items' => @recipes,
      'total' => @total,
      'first_num' => @first_num,
      'last_num' => @last_num
    }
  end

  private

  def page
    @page ||=
      begin
        max_page = (@total.to_f / page_size).ceil
        req_page = (@params['page'] || 1).to_i
        req_page > 0 && req_page <= max_page ? req_page : 1
      end
  end

  def page_size
    @page_size ||=
      if @params['page_size'].nil? || @params['page_size'] <= 0
        DEFAULT_PAGE_SIZE
      else
        @params['page_size']
      end
  end

  def paginate!
    # E.g. - Dataset is 7 records. Request is for Page 3, with Page Size of 2
    #
    #       P1    P2    P3    P4
    #      ----------------------
    # idx   0 1   2 3   4 5   6
    # num   1 2   3 4   5 6   7
    #
    #   * sql OFFSET will be page-1 * page_size = 2 * 2 = 4
    #   * sql LIMIT will be page_size = 2
    #   * first_num will be (page * page_size) + 1 = offset + 1 = 5
    #   * last_num will be first_num + page_size - 1 = 5 + 2 - 1 = 6
    #     * exception: if first or last num are > total, they will be trimmed
    #       to total
    #
    offset = (page - 1) * page_size
    limit = page_size
    @recipes = @recipes.offset(offset).limit(limit)

    @first_num = offset + 1
    @last_num = @first_num + page_size - 1

    # Trim if needed
    @first_num = @total if @first_num > @total
    @last_num = @total if @last_num > @total
  end

  def search!
    return if @params['search'].nil? || @params['search'].length == 0

    @params['search'].split(' ').each do |token|
      @recipes = @recipes.where("LOWER(name) LIKE '%#{token.downcase}%'")
    end
  end

  def sort!
    # Sort by `name` if explicitly specified. If not, sort by recently created
    # as a default.
    field, direction =
      if @params['sort_by']&.downcase == 'name'
        [:name, :asc]
      else
        [:created_at, :desc]
      end

    @recipes = @recipes.order("#{field} #{direction}")
  end
end