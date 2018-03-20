class ProductsDatatable
  delegate :params, :h, :link_to, :number_to_currency, to: :@view

  def initialize(view, products)
    @view = view
    @products = products
  end

  def as_json(option = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Product.count,
      aaData: data
    }
  end

  private

  def data
    @products.includes(:pg_products).map do |product|
      [
        product.product_sku,
        product.product_name,
        product.status,
        product.unit_of_measure,
        product.status,
        link_to('<i class="fa fa-pencil"></i>'.html_safe, @view.edit_business_product_path(product.business_id, product), 
                data: { toggle:'tooltip'}, title: 'Edit', class: 'btn btn-default'),
        delete_link(product)
      ]
    end
  end

  def delete_link(product)
    if product.can_destroy?
      '--'
    else
      link_to('<i class="fa fa-trash-o"></i>'.html_safe, @view.business_product_path(product.business_id, product), 
              data: { toggle:'tooltip', confirm: I18n.t('attention.confirm_deletion')}, 
              title: 'Delete', class: 'btn btn-danger', method: :delete)
    end
  end

end
