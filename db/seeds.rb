teacher_in = Teacher.create!(name:'Jose', age:'33', subject:'Ingles')

teacher_mat = Teacher.create!(name:'Maria', age:'33', subject:'Matematica')

teacher_in.courses.create!(name:'Ingles do Zero',
                           description:'Aprendendo Ingles do Zero',
                           time:'20 horas')

teacher_in.courses.create!(name:'Ingles intermediario',
                           description:'Aprendendo Ingles intermediario',
                           time:'35 horas')

teacher_mat.courses.create!(name:'Somando',
                            description:'Aprendendo a somar numeros',
                            time:'55 horas')
