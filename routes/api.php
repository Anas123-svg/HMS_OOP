<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\PatientController;
use App\Http\Controllers\AppointmentController;
use App\Http\Controllers\Appointment2Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::post('/auth/register',[AuthController::class, 'register']);
Route::post('/auth/login',[AuthController::class, 'login']);
Route::get('/doctors', [AuthController::class, 'getDoctors']);
//Route::post('/auth/login',[PatientController::class, 'index']);
Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');
Route::get('/patients', [PatientController::class, 'index']);
Route::get('/inpatients', [PatientController::class, 'inPatients']);
Route::get('/outpatients', [PatientController::class, 'outPatients']);
Route::get('/patient-count-by-day', [PatientController::class, 'patientCountByDay']);
Route::put('patients/{id}', [PatientController::class, 'update']);



Route::get('appointments', [AppointmentController::class, 'index']);
Route::get('appointments/patient/{patientId}', [AppointmentController::class, 'getByPatient']);
Route::get('appointments/doctor/{doctorId}', [AppointmentController::class, 'getByDoctor']);
Route::get('appointments/{id}', [AppointmentController::class, 'show']);
Route::post('appointments', [AppointmentController::class, 'store']);







Route::get('appointments2', [Appointment2Controller::class, 'index']);
Route::get('appointments2/patient/{patientId}', [Appointment2Controller::class, 'getByPatient']);
Route::get('appointments2/doctor/{doctorName}', [Appointment2Controller::class, 'getByDoctorName']);
Route::get('appointments2/doctor/{doctorId}', [Appointment2Controller::class, 'getByDoctor']);
Route::get('appointments2/{id}', [Appointment2Controller::class, 'show']);
Route::post('appointments2', [Appointment2Controller::class, 'store']);
Route::put('appointments2/{id}', [Appointment2Controller::class, 'update']);
Route::post('/appointments2_create', [Appointment2Controller::class, 'create']);