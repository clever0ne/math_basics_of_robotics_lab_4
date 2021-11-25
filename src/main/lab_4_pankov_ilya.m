% Лабораторная работа №4
clc; close all; clear;

%% Задание 1. Прямая задача кинематики
q = load_data('../../joint_coordinates.txt');

tform1 = rpr_fk(q(1, :)); 
tform2 = rpr_fk(q(end, :));

%% Задание 2. Обратная задача кинематики
q = q(end, :);
tform = rpr_fk(q);

q_ik = rpr_ik(tform);
tform_ik = rpr_fk(q_ik);
