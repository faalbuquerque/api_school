require 'rails_helper'

describe 'Courses API' do
  context 'GET /api/v1/courses' do
    it 'get courses' do
      teacher = Teacher.create!(name:'Jose', age:'33', subject:'Ingles')

      teacher.courses.create!(name:'Ingles do Zero',
                              description:'Aprendendo Ingles do Zero',
                              time:'20 horas')

      teacher.courses.create!(name:'Ingles avancado',
                              description:'Aprendendo Ingles avancado',
                              time:'40 horas')

      get '/api/v1/courses'

      #transforma em array com hash a resposta do corpo da api
      parsed_body = JSON.parse(response.body)

      #metodo content_type: verifica se esta no formarto js
      expect(response.content_type).to include('application/json')

      #verifica status da requisicao
      expect(response).to have_http_status(:ok)

      #conta se a quantidade de itens do array é a mesma da quantidade de cursos
      expect(parsed_body.count).to eq(Course.count)

      #como transformei em array com o JSON.parse consigo buscar especificamente a posicao do array e chave do hash
      expect(parsed_body[0]['name']).to eq('Ingles do Zero')
      expect(parsed_body[1]['name']).to eq('Ingles avancado')
    end

    it 'not return courses' do

      get '/api/v1/courses'

      parsed_body = JSON.parse(response.body)
      expect(response.content_type).to include('application/json')
      expect(response).to have_http_status(:ok)

      expect(parsed_body).to be_empty
    end
  end

  context 'GET /api/v1/courses/:id' do
    it 'return a course' do
      teacher = Teacher.create!(name:'Jose', age:'33', subject:'Ingles')

      course = teacher.courses.create!(name:'Ingles do Zero',
                                       description:'Aprendendo Ingles do Zero',
                                       time:'20 horas')

      teacher.courses.create!(name:'Ingles avancado',
                              description:'Aprendendo Ingles avancado',
                              time:'40 horas')

      get "/api/v1/courses/#{course.id}"

      parsed_body = JSON.parse(response.body)

      expect(response.content_type).to include('application/json')
      expect(response).to have_http_status(:ok)
      expect(parsed_body['name']).to eq('Ingles do Zero')
      expect(parsed_body['name']).to_not eq('Ingles avancado')
    end

    it 'not return a course' do

      get '/api/v1/courses/1234'

      expect(response).to have_http_status(:not_found)
    end
  end

  context 'POST /api/v1/courses/' do
    it 'create a course' do

      teacher = Teacher.create!(name:'Jose', age:'33', subject:'Ingles')

      post '/api/v1/courses', params: {
                                course: {
                                  name:'Ingles do Zero',
                                  description:'Aprendendo Ingles do Zero',
                                  time:'20 horas',
                                  teacher_id: teacher.id
                                }
                              }

      parsed_body = JSON.parse(response.body)
      expect(response.content_type).to include('application/json')
      expect(response).to have_http_status(:created)
      expect(parsed_body['name']).to eq('Ingles do Zero')
      expect(parsed_body['description']).to eq('Aprendendo Ingles do Zero')
      expect(parsed_body['time']).to eq('20 horas')
      expect(parsed_body['code']).to eq(Course.first.code)
    end

    it 'invalid parameters' do

      teacher = Teacher.create!(name:'Jose', age:'33', subject:'Ingles')

      post '/api/v1/courses', params: {
                                course: {
                                  name:'',
                                  description:'',
                                  time:''
                                }
                              }
      expect(response.content_type).to include('application/json')
      expect(response).to have_http_status(:precondition_failed)
      expect(response.body).to include('Oops, Parametros invalidos!')
    end
  end

  context 'generate code' do
    it 'generate random code' do
      teacher = Teacher.create!(name:'Jose', age:'33', subject:'Ingles')

      course = teacher.courses.create!(name:'Ingles do Zero',
                                      description:'Aprendendo Ingles do Zero',
                                      time:'20 horas', code: '9d04efe4dc40e059c4c9')

      expect(course.code).to be_present
    end

    it 'if repeat random code' do
      teacher = Teacher.create!(name:'Jose', age:'33', subject:'Ingles')

      course = teacher.courses.create!(name:'Ingles do Zero',
                                      description:'Aprendendo Ingles do Zero',
                                      time:'20 horas')

      course_stub = teacher.courses.new(name:'Ingles do Zero',
                                          description:'Aprendendo Ingles do Zero',
                                          time:'20 horas')
      allow(Digest::SHA256).to receive(:hexdigest).and_return(course.code, '11111111111111111111')
      course_stub.save!

      expect(course.code).to_not eq(course_stub.code)
      expect(course_stub.code).to eq('11111111111111111111')
    end
  end
end

