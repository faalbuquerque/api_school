teacher_in = Teacher.create!(name:'Jose', age:'33', subject:'Ingles')

teacher_mat = Teacher.create!(name:'Maria', age:'33', subject:'Matematica')

teacher_in.courses.create!(name:'Ingles do Zero',
                           description:'Aprendendo Ingles do Zero',
                           time:'20 horas', code: '9d04eqe4dc40e059c4c9')

teacher_in.courses.create!(name:'Ingles intermediario',
                           description:'Aprendendo Ingles intermediario',
                           time:'35 horas', code: '9d04efe7dc40e059c4c9')

teacher_mat.courses.create!(name:'Somando',
                            description:'Aprendendo a somar numeros',
                            time:'55 horas', code: '9d04efe4dc40e059c4c9')
