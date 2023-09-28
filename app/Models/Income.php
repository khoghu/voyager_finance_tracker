<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;


class Income extends Model
{
    protected $table = 'incomes';

    protected $fillable = [
        'user_id',
        'group_id',
        'title',
        'description',
        'amount',
        'attachment',
        'debited_at',
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
