<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;


class Expense extends Model
{
    protected $table = 'expenses';

    protected $fillable = [
        'user_id',
        'group_id',
        'title',
        'description',
        'amount',
        'status',
        'attachment',
        'credited_at',
    ];

    
    /**
     * Get the user from records.
     */
    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    /**
     * Get the group from records.
     */
    public function group(): BelongsTo
    {
        return $this->belongsTo(FinanceGroup::class);
    }
}
