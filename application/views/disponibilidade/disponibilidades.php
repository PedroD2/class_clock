		<div id="content" class="col-md-10">

			<?php if($this->session->flashdata('success')) : ?>
				<div class="text-center alert alert-success">
					<span class="glyphicon glyphicon glyphicon-ok" aria-hidden="true"></span>
					<?= $this->session->flashdata('success') ?>
				</div>
			<?php elseif ($this->session->flashdata('danger')) : ?>
				<div class="text-center alert alert-danger">
					<span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
					<?= $this->session->flashdata('danger') ?>
				</div>
			<?php endif; ?>

			<!-- Cadastro das preferências do professor -->
			<?= form_open('Professor/disponibilidade') ?>
				<div class="col-md-12">
					<div class="container">
						<div class="row">
							<div id="main-content" class='col-sm-8'>
								<h1>Disponibilidade</h1>
								<div class="table-responsive">
									<table id="listas" class="table">
										<tr>
											<th>Dia</th>
											<th>Período</th>
											<th>Início</th>
											<th>Fim</th>
										</tr>
										<tr class="form-row">
											<td>
												<?= form_dropdown('dia',$dia,null,array('class'=>'form-control')) ?>
												<?= form_error('dia') ?>
											</td>
											<td>
												<?= form_dropdown('periodo',$periodo,null,array('id'=>'periodo','class'=>'form-control')) ?>
												<?= form_error('periodo') ?>
											</td>
											<td>
												<?= form_dropdown('inicio',$horas,null,array('id'=>'inicio','class'=>'form-control','disabled'=>'disabled')) ?>
												<?= form_error('inicio') ?>
											</td>
											<td>
												<?= form_input('fim','',array('id'=>'fim','class'=>'form-control','readonly'=>'readonly')) ?>
											</td>
										</tr>
									</table>
								</div>
							</div>
							<div class="row">
								<div class='col-sm-8'>
									<div  style="margin-left:15px;">
										<button name="cadastrar" type='submit' class='btn bt-lg btn-primary'>Cadastrar</button>
									</div>
								</div>
							</div>

							<div class="row" style="margin-top:100px;">
								<div class="col-sm-10">
									<h3 class="text-center">Tabela de disponibilidade</h3>
									<table class="table table-bordered">
										<tr>
											<th class="text-center">Dia</th>
											<th class="text-center" colspan="16">Horário</th>
										</tr>
										<?php foreach ($disponibilidade as $dia) : ?>
											<tr>
											<?php if ($dia) :?>
												<td style="vertical-align: middle;"><?= ucfirst($dia[0]['dia']) ?></td>
												<?php foreach ($dia as $horario) : ?>
													<td><?= removerSegundos($horario['inicio'])?> - <?= removerSegundos($horario['fim']) ?>  <?= anchor ('Professor/removeHorario/'.$horario['id'], '<span class="glyphicon glyphicon-remove text-danger" ></span>') ?></td>
												<?php endforeach; ?>
											<?php endif; ?>
											</tr>
										<?php endforeach; ?>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div><!--Fecha content-->
			<?= form_close() ?>
		</div><!--Fecha container-fluid-->
