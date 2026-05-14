class ContentsController < ApplicationController
  layout "klass"

  before_action :set_klass, only: %i[ index new create ]
  before_action :set_content, only: %i[ show edit update destroy ]
  before_action :set_modules, only: %i[ new edit ]

  def index
    @contents = policy_scope(@klass.contents)
    @contents = @contents.order(:module_name, :created_at)
  end

  def show
  end

  def new
    @content = @klass.contents.new
    authorize @content
  end

  def create
    @content = authorize @klass.contents.new(content_params)
    @content.user = Current.user

    # Override module_name if a new one was provided
    if params[:content][:new_module_name].present?
      @content.module_name = params[:content][:new_module_name]
    end

    if @content.save
      redirect_to [ @klass, @content ], notice: "content created", status: :see_other
    else
      render :new, status: :unprocessable_content
    end
  end

  def edit
    authorize @content
  end

  def update
    authorize @content
    if @content.update(content_params)
      redirect_to [ @klass, @content ], notice: "content updated"
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    authorize @content
    klass = @content.klass
    @content.destroy
    redirect_to [ klass, :contents ], alert: "content deleted"
  end

  private
    def set_klass
      @klass = policy_scope(Klass).find(params[:klass_id])
    end

    def set_content
      @content = policy_scope(Content).find(params[:id])
      @klass = @content.klass
    end

    def set_modules
      @modules = if action_name == "new"
        @klass.contents.distinct.pluck(:module_name).compact
      else
        @content.klass.contents.distinct.pluck(:module_name).compact
      end
    end

    def content_params
      params.require(:content).permit(
        :module_name,
        :file,
        :title,
        :description
      )
    end
end
