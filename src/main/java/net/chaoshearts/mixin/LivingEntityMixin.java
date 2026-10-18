package net.chaoshearts.mixin;

import com.llamalad7.mixinextras.sugar.Local;
import org.spongepowered.asm.mixin.Mixin;
import org.spongepowered.asm.mixin.injection.At;
import org.spongepowered.asm.mixin.injection.ModifyVariable;

import net.chaoshearts.ability.AbilityManager;
import net.minecraft.world.damagesource.DamageSource;
import net.minecraft.world.entity.LivingEntity;

/** Lets heart passives and trials change damage before armour is applied. */
@Mixin(LivingEntity.class)
public abstract class LivingEntityMixin {
	@ModifyVariable(method = "hurtServer", at = @At("HEAD"), argsOnly = true)
	private float chaoshearts$modifyDamage(float amount, @Local(argsOnly = true) DamageSource source) {
		return AbilityManager.modifyDamage((LivingEntity) (Object) this, source, amount);
	}
}
