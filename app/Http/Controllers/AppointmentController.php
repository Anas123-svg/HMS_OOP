<?php

namespace App\Http\Controllers;

use App\Models\Appointment;
use Illuminate\Http\Request;

class AppointmentController extends Controller
{
    public function store(Request $request)
    {
        $validatedData = $request->validate([
            'patient_id' => 'required|exists:patients,id',
            'doctor_id' => 'required|exists:users,id', 
            'appointment_date' => 'required|date',
            'status' => 'nullable|string',
            'notes' => 'nullable|string',
        ]);

        $appointment = Appointment::create($validatedData);

        return response()->json($appointment, 201);
    }

    public function index()
    {
        $appointments = Appointment::with(['patient', 'doctor'])->get();
        return response()->json($appointments);
    }


    public function getByPatient($patientId)
    {
        $appointments = Appointment::where('patient_id', $patientId)->with(['patient', 'doctor'])->get();
        return response()->json($appointments);
    }

    
    public function getByDoctor($doctorId)
    {
        $appointments = Appointment::where('doctor_id', $doctorId)->with(['patient', 'doctor'])->get();
        return response()->json($appointments);
    }


    public function show($id)
    {
        $appointment = Appointment::with(['patient', 'doctor'])->findOrFail($id);
        return response()->json($appointment);
    }
}
