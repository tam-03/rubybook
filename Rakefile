# frozen_string_literal: true

CC = 'gcc'

task default: 'addition'
desc 'compile addition.c file'
file 'addition' => 'addition.c' do
  sh "#{CC} -o addition addition.c"
end
