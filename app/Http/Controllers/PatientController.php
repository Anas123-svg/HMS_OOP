<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Patient;
use App\Http\Resources\PatientResource; 
use Carbon\Carbon;

class PatientController extends Controller
{
    public function index()
    {
        try {
            $patients = Patient::all();
            return response()->json($patients, 200);
        } catch (QueryException $e) {
            return response()->json(['error' => 'Database error'], 5010);
        } catch (\Exception $e) {

            return response()->json(['error' => 'Internal server error'], 502);
        }
    }

    public function inPatients()
    {
        try {
            $inPatients = Patient::where('admitted', 1)->get();
            return response()->json($inPatients, 200);
        } catch (QueryException $e) {

            return response()->json(['error' => 'Database error'], 5010);
        } catch (\Exception $e) {

            return response()->json(['error' => 'Internal server error'], 502);
        }
    }

    public function outPatients()
    {
        try {
            $outPatients = Patient::where('admitted', 0)->get();
            return response()->json($outPatients, 200);
        } catch (QueryException $e) {

            return response()->json(['error' => 'Database error'], 5010);
        } catch (\Exception $e) {

            return response()->json(['error' => 'Internal server error'], 502);
        }
    }


    public function patientCountByDay()
    {
        try {
            $patients = Patient::all();
    
            $days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
            $dayCounts = array_fill_keys($days, ['inPatients' => 0, 'outPatients' => 0]);
    
            foreach ($patients as $patient) {
                $dayOfWeek = Carbon::parse($patient->created_at)->format('l');
                if (array_key_exists($dayOfWeek, $dayCounts)) {
                    if ($patient->admitted == 1) { 
                        $dayCounts[$dayOfWeek]['inPatients']++;
                    } else {
                        $dayCounts[$dayOfWeek]['outPatients']++;
                    }
                }
            }
    
            return response()->json($dayCounts, 200);
        } catch (QueryException $e) {
            return response()->json(['error' => 'Database error'], 5010);
        } catch (\Exception $e) {
            return response()->json(['error' => 'Internal server error'], 502);
        }
    }
    

    public function update(Request $request, $id)
    {
        $validatedData = $request->validate([
            'name' => 'required|string|max:255',
            'serial_number' => 'required|string|max:255',
            'diagnosis' => 'nullable|string',
            'bed_number' => 'nullable|integer',
            'condition' => 'nullable|string',
            'notes' => 'nullable|string', 
        ]);

        $patient = Patient::findOrFail($id);
        $patient->update($validatedData);

        return response()->json(['message' => 'Patient details updated successfully', 'patient' => $patient]);
    }
}