/*
 *  Criado por e Data: 01/11/2023 André Luna
 *  contato: 
 *  Objetivo: Servir de acionador geral para o objeto Task
 *  Data da Ultima atualizacao e por quem: 01/11/2023  André Luna
 *
*/
trigger ADL_Task on Task (after insert) {
    if (Trigger.isAfter && Trigger.isInsert) {
        for (Task newTask : Trigger.new) {   ADL_TaskSendNotification.enviarNotificacao(newTask);  }
    }
}