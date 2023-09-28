<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;


class StaticExpense extends Model
{
    protected $table = 'static_expenses';

    protected $fillable = [
        'user_id',
        'group_id',
        'title',
        'description',
        'amount',
        'credit_day_per_month',
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
