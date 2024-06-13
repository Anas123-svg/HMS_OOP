<?php

namespace App\Http\Controllers;

use App\Models\Appointment2;
use App\Models\User;
use Illuminate\Http\Request;
use App\Models\Patient; 
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Validator;
class Appointment2Controller extends Controller
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

        $appointment = Appointment2::create($validatedData);

        return response()->json($appointment, 201);
    }

    public function index()
    {
        $appointments = Appointment2::with(['patient', 'doctor'])->get();
        return response()->json($appointments);
    }

    public function getByPatient($patientId)
    {
        $appointments = Appointment2::where('patient_id', $patientId)->with(['patient', 'doctor'])->get();
        return response()->json($appointments);
    }

   
    public function getByDoctor($doctorId)
    {
        $appointments = Appointment2::where('doctor_id', $doctorId)->with(['patient', 'doctor'])->get();
        return response()->json($appointments);
    }

  
    public function getByDoctorName($doctorName)
    {
        $doctor = User::where('name', $doctorName)->where('designation', 'Doctor')->first();

        if (!$doctor) {
            return response()->json(['message' => 'Doctor not found'], 404);
        }

        $appointments = Appointment2::where('doctor_id', $doctor->id)->with(['patient', 'doctor'])->get();
        return response()->json($appointments);
    }

    public function show($id)
    {
        $appointment = Appointment2::with(['patient', 'doctor'])->findOrFail($id);
        return response()->json($appointment);
    }

    public function update(Request $request, $id)
    {

        $appointment = Appointment2::findOrFail($id);
        
        $validatedData = $request->validate([
            'patient_id' => 'exists:patients,id',
            'doctor_id' => 'exists:users,id',
            'appointment_date' => 'date',
            'status' => 'string',
            'notes' => 'nullable|string',
        ]);

        $appointment->update($validatedData);

        
        return response()->json(['message' => 'Appointment updated successfully'], 200);
    }

    public function create(Request $request)
    {
        DB::beginTransaction(); 
    
        try {
            $patient = Patient::find($request->patient_id);
    
            if (!$patient) {
                $patient = Patient::create([
                    'name' => $request->name,
                    'serialNumber' => $request->serialNumber,
                    'diagnosis' => $request->diagnosis,
                    'bedNumber' => $request->bedNumber,
                    'condition' => $request->condition,
                    'admitted' => $request->admitted,
                    'date' => $request->date,
                    'notes' => $request->notes,
                ]);
            }
  
            $appointment = Appointment2::create([
                'patient_id' => $patient->id,
                'doctor_id' => $request->doctor_id,
                'appointment_date' => $request->appointment_date,
                'status' => $request->status,
                'notes' => $request->notes,
            ]);
    
            DB::commit(); 
    
            return response()->json(['message' => 'Appointment created successfully', 'appointment' => $appointment], 201);
        } catch (\Exception $e) {
            DB::rollBack(); 
    
            return response()->json(['error' => 'Failed to create appointment', 'message' => $e->getMessage()], 500);
        }
    }
    
}
