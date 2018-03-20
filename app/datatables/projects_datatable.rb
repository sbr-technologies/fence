class ProjectsDatatable
  delegate :params, :h, :link_to, :number_to_currency, to: :@view

  def initialize(view, projects)
    @view = view
    @projects = projects
  end

  def as_json(option = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Project.count,
      aaData: data
    }
  end

  private

  def data
    @projects.includes(:project_category).map do |project|
      [
        check_box(project),
        project_name(project),
        project_category(project),
        project.status,
        link_to('<i class="fa fa-pencil"></i>'.html_safe, @view.edit_organization_project_path(project.organization_id, project), 
                data: { toggle:'tooltip'}, title: 'Edit', class: 'btn btn-default'),
      ]
    end
  end

  def delete_link(product)
    if product.can_destroy?
      '--'
    else
      link_to('<i class="fa fa-trash-o"></i>'.html_safe, @view.organization_product_path(product.organization_id, product), 
        data: { toggle:'tooltip', confirm: I18n.t('attention.confirm_deletion')}, 
        title: 'Delete', class: 'btn btn-danger', method: :delete)
      end
    end

  end
  
  def check_box(project)
    '<div class="checkbox_div text-center"><label><input type="checkbox" /><span></span></label></div>'
  end
  
  def project_name(project)
    "<div class=\"relativ_div\">
      <a href=\"#\" class=\"view_projects_list_name\">#{project.name}</a>
      <div class=\"edit_projects_list_name\" style=\"display:none\">
      <input type=\"text\" value=\"#{project.name}\" /><button class=\"save_projects_list_name\">Save</button><button class=\"cancel_projects_list_name\">cancel</button>
      </div>
    </div>"
  end
  
  def project_category(project)
    "<div class=\"relativ_div\">
    #{project.project_category.description}
      <span class=\"shotring_part1\">
        <a class=\"shotring_part1_top\" href= \"#\" title=\"Edit\">
          <i class=\"fa fa-angle-down\"></i>
        </a>
      </span>
    </div>"
  end
