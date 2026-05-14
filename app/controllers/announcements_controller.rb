class AnnouncementsController < ApplicationController
  layout "klass"

  before_action :set_klass, only: %i[ index new create ]
  before_action :set_announcement, only: %i[ show edit update destroy ]

  def index
    @announcements = policy_scope(@klass.announcements)
      .order(updated_at: :desc)
    @announcements = @announcements.page(params[:page])
  end

  def show
  end

  def new
    @announcement = @klass.announcements.new
    authorize @announcement
  end

  def create
    @announcement = authorize @klass.announcements.new(announcement_params)
    @announcement.user = Current.user

    if @announcement.save
      redirect_to [ @klass, @announcement ], notice: "announcement created", status: :see_other
    else
      render :new, status: :unprocessable_content
    end
  end

  def edit
    authorize @announcement
  end

  def update
    authorize @announcement
    if @announcement.update(announcement_params)
      redirect_to [ @klass, @announcement ], notice: "announcement updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @announcement
    klass = @announcement.klass
    @announcement.destroy
    redirect_to klass_announcements_path(klass), alert: "announcement deleted"
  end

  private
    def set_klass
      @klass = policy_scope(Klass).find(params[:klass_id])
    end

    def set_announcement
      @announcement = policy_scope(Announcement).find(params[:id])
      @klass = @announcement.klass
    end

    def announcement_params
      params.require(:announcement).permit(:content)
    end
end
