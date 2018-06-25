# frozen_string_literal: true

require 'pug'
require_relative '../../spec_helpers/mock_action'

describe Pug::Action::Controller do
  describe 'actions?' do
    it 'should return false for nil actions' do
      controller = Pug::Action::Controller.new(nil)
      expect(controller.actions?).to be false
    end

    it 'should return false for empty actions' do
      controller = Pug::Action::Controller.new([])
      expect(controller.actions?).to be false
    end

    it 'should return true for any actions' do
      action = MockAction.new('Command')
      controller = Pug::Action::Controller.new([action])
      expect(controller.actions?).to be true
    end
  end

  describe 'running_action?' do
    it 'should return false when not running a action' do
      action = MockAction.new('Command')
      controller = Pug::Action::Controller.new([action])
      expect(controller.running_action?).to be false
    end

    it 'should return true when running a action' do
      action = MockAction.new('Command')
      controller = Pug::Action::Controller.new([action])
      controller.start_action(0)
      expect(controller.running_action?).to be true
    end
  end

  describe 'action_input' do
    it 'should raise an error when not running a action' do
      action = MockAction.new('Command')
      controller = Pug::Action::Controller.new([action])
      expect { controller.action_input }.to raise_error(RuntimeError)
    end

    it 'should indicate false when running action requires no inputs' do
      action = MockAction.new('Command', false)
      controller = Pug::Action::Controller.new([action])
      controller.start_action(0)
      input = controller.action_input
      expect(input.required?).to be false
    end

    it 'should indicate true when running action requires inputs' do
      action = MockAction.new('Command', true)
      controller = Pug::Action::Controller.new([action])
      controller.start_action(0)
      input = controller.action_input
      expect(input.required?).to be true
    end
  end

  describe 'can_start_action?' do
    it 'should return false for out of bounds index' do
      action = MockAction.new('Command')
      controller = Pug::Action::Controller.new([action])
      expect(controller.can_start_action?(-1)).to be false
      expect(controller.can_start_action?(1)).to be false
    end

    it 'should return false if there is already a running action' do
      action = MockAction.new('Command')
      controller = Pug::Action::Controller.new([action])
      controller.start_action(0)
      expect(controller.can_start_action?(0)).to be false
    end

    it 'should return true if there is no already running action' do
      action = MockAction.new('Command')
      controller = Pug::Action::Controller.new([action])
      expect(controller.can_start_action?(0)).to be true
    end
  end

  describe 'start_action' do
    it 'should not start running a action if it can not start action' do
      action = MockAction.new('Command')
      controller = Pug::Action::Controller.new([action])
      controller.start_action(10)
      expect(controller.running_action?).to be false
    end

    it 'should start running a action if it can start action' do
      action = MockAction.new('Command')
      controller = Pug::Action::Controller.new([action])
      controller.start_action(0)
      expect(controller.running_action?).to be true
    end
  end

  describe 'run_action' do
    it 'should return an error result if not running action' do
      action = MockAction.new('Command')
      controller = Pug::Action::Controller.new([action])
      allow(action).to receive(:requires_inputs?) { true }
      result = controller.run_action('')
      expect(result.type).to eq(Pug::Types::Result::ERROR)
      expect(result.error).to eq(Pug::Strings.no_action_running)
    end

    it 'should return success with empty string if action has no output' do
      action = MockAction.new('Command', true, nil)
      controller = Pug::Action::Controller.new([action])
      controller.start_action(0)
      result = controller.run_action('')
      expect(result.type).to eq(Pug::Types::Result::SUCCESS)
      expect(result.value.value).to be_empty
    end

    it 'should return success with output if action has an output' do
      action = MockAction.new('Command', true, 'Output')
      controller = Pug::Action::Controller.new([action])
      controller.start_action(0)
      result = controller.run_action('')
      expect(result.type).to eq(Pug::Types::Result::SUCCESS)
      expect(result.value.value).to eq('Output')
    end

    it 'should clear the running action' do
      action = MockAction.new('Command', true, 'Output')
      controller = Pug::Action::Controller.new([action])
      controller.start_action(0)
      controller.run_action('')
      expect(controller.running_action?).to be false
    end
  end
end
