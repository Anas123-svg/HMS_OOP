<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class PatientResource extends JsonResource
{
    public function toArray($request)
    {
        return [
            'name' => $this->name,
            'serialNumber' => $this->serialNumber,
            'diagnosis' => $this->diagnosis,
            'bedNumber' => $this->bedNumber,
            'condition' => $this->condition,
            'admitted' => $this->admitted,
        ];
    }
}
