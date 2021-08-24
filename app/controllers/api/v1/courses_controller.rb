class Api::V1::CoursesController <  ActionController::API
  def index
    @courses = Course.all

    render json: @courses.as_json(except: [:id, :created_at, :updated_at, :teacher_id],
                                  include: :teacher)
  end

  def show
    @course = Course.find_by(id: params[:id])

    if @course
      render json: @course.as_json(except: [:id, :created_at, :updated_at, :teacher_id],
                                   include: :teacher)
    else
      render json: 'Oops, algo deu errado!', status: :not_found
    end
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      render json: @course.as_json(except: [:id, :created_at, :updated_at, :teacher_id],
                                 include: :teacher), status: :created
    else
      render json: {message: 'Oops, Parametros invalidos!'}, status: :precondition_failed
    end
  end

  private

  def course_params
    params.require(:course).permit(:name, :description, :time, :code, :teacher_id)
  end
end
